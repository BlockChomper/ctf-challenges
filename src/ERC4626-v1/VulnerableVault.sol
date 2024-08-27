// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";

contract VulnerableVault is ERC20 {
    using SafeERC20 for IERC20;
    using Math for uint256;

    IERC20 public immutable asset;

    event Deposit(address indexed caller, address indexed owner, uint256 assets, uint256 shares);
    event Withdraw(address indexed caller, address indexed receiver, address indexed owner, uint256 assets, uint256 shares);

    constructor(IERC20 _asset) ERC20("Vulnerable Vault", "vVLT") {
        asset = _asset;
    }

    function deposit(uint256 assets, address receiver) public virtual returns (uint256 shares) {
        require(assets <= maxDeposit(receiver), "ERC4626: deposit more than max");

        shares = previewDeposit(assets);
        
        asset.safeTransferFrom(msg.sender, address(this), assets);
        _mint(receiver, shares);

        emit Deposit(msg.sender, receiver, assets, shares);
    }

    function withdraw(uint256 assets, address receiver, address owner) public virtual returns (uint256 shares) {
        require(assets <= maxWithdraw(owner), "ERC4626: withdraw more than max");

        shares = previewWithdraw(assets);
        
        if (msg.sender != owner) {
            _spendAllowance(owner, msg.sender, shares);
        }

        _burn(owner, shares);
        asset.safeTransfer(receiver, assets);

        emit Withdraw(msg.sender, receiver, owner, assets, shares);
    }

    function previewDeposit(uint256 assets) public view virtual returns (uint256) {
        return assets;
    }

    function previewWithdraw(uint256 assets) public view virtual returns (uint256) {
        uint256 supply = totalSupply();
        return supply == 0 ? assets : assets.mulDiv(supply, totalAssets(), Math.Rounding.Ceil);
    }

    function maxDeposit(address) public view virtual returns (uint256) {
        return type(uint256).max;
    }

    function maxWithdraw(address owner) public view virtual returns (uint256) {
        return convertToAssets(balanceOf(owner));
    }

    function totalAssets() public view virtual returns (uint256) {
        return asset.balanceOf(address(this));
    }

    function convertToShares(uint256 assets) public view virtual returns (uint256) {
        uint256 supply = totalSupply();
        return supply == 0 ? assets : assets.mulDiv(supply, totalAssets(), Math.Rounding.Floor);
    }

    function convertToAssets(uint256 shares) public view virtual returns (uint256) {
        uint256 supply = totalSupply();
        return supply == 0 ? shares : shares.mulDiv(totalAssets(), supply, Math.Rounding.Floor);
    }
}