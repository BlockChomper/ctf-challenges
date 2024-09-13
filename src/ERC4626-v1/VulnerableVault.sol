// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";
import "@openzeppelin/contracts/interfaces/IERC4626.sol";

contract VulnerableVault is ERC20, IERC4626 {
    using SafeERC20 for IERC20;
    using Math for uint256;

    IERC20 private immutable _asset;

    constructor(IERC20 assetToken) ERC20("Vulnerable Vault", "vVLT") {
        _asset = assetToken;
    }

    function asset() public view virtual override returns (address) {
        return address(_asset);
    }

    function deposit(uint256 assets, address receiver) public virtual override returns (uint256 shares) {
        uint256 supply = totalSupply();
        shares = supply == 0 ? assets : (assets * supply) / totalAssets();
        _mint(receiver, shares);
        _asset.safeTransferFrom(msg.sender, address(this), assets);
        emit Deposit(msg.sender, receiver, assets, shares);
    }

    function mint(uint256 shares, address receiver) public virtual override returns (uint256 assets) {
        if (msg.sender != owner) {
            uint256 maxAssets = convertToAssets(allowance(owner, msg.sender));
            require(assets <= maxAssets, "Withdraw amount exceeds allowance");
            _spendAllowance(owner, msg.sender, convertToShares(assets));
        }

        assets = convertToAssets(shares);
        _mint(receiver, shares);
        _asset.safeTransferFrom(msg.sender, address(this), assets);
        emit Deposit(msg.sender, receiver, assets, shares);
    }

    function withdraw(uint256 assets, address receiver, address owner) public virtual override returns (uint256 shares) {
        if (msg.sender != owner) {
            uint256 maxAssets = convertToAssets(allowance(owner, msg.sender));
            require(assets <= maxAssets, "Withdraw amount exceeds allowance");
            _spendAllowance(owner, msg.sender, convertToShares(assets));
        }

        shares = convertToShares(assets);
        require(shares <= balanceOf(owner), "Withdraw amount exceeds balance");

        _burn(owner, shares);
        _asset.safeTransfer(receiver, assets);

        emit Withdraw(msg.sender, receiver, owner, assets, shares);
        return shares;
    }

    function redeem(uint256 shares, address receiver, address owner) public virtual override returns (uint256 assets) {
        if (msg.sender != owner) {
            _spendAllowance(owner, msg.sender, shares);
        }
        assets = convertToAssets(shares);
        _burn(owner, shares);
        _asset.safeTransfer(receiver, assets);
        emit Withdraw(msg.sender, receiver, owner, assets, shares);
    }

    function totalAssets() public view virtual override returns (uint256) {
        return _asset.balanceOf(address(this));
    }

    function convertToShares(uint256 assets) public view virtual override returns (uint256) {
        uint256 supply = totalSupply();
        return supply == 0 ? assets : assets.mulDiv(supply, totalAssets(), Math.Rounding.Floor);
    }

    function donateAssets(uint256 amount) public {
        _asset.safeTransferFrom(msg.sender, address(this), amount);
    }

     function convertToAssets(uint256 shares) public view virtual override returns (uint256) {
        uint256 supply = totalSupply();
        if (supply == 0) {
            return shares;
        }
        return (shares * totalAssets() * 100) / supply;
    }

    function previewDeposit(uint256 assets) public view virtual override returns (uint256) {
        return convertToShares(assets);
    }

    function previewMint(uint256 shares) public view virtual override returns (uint256) {
        return convertToAssets(shares);
    }

    function previewWithdraw(uint256 assets) public view virtual override returns (uint256) {
        return convertToShares(assets);
    }

    function previewRedeem(uint256 shares) public view virtual override returns (uint256) {
        return convertToAssets(shares);
    }

    function maxDeposit(address) public view virtual override returns (uint256) {
        return type(uint256).max;
    }

    function maxMint(address) public view virtual override returns (uint256) {
        return type(uint256).max;
    }

    function maxWithdraw(address owner) public view virtual override returns (uint256) {
        return convertToAssets(balanceOf(owner));
    }

    function maxRedeem(address owner) public view virtual override returns (uint256) {
        return balanceOf(owner);
    }
}


