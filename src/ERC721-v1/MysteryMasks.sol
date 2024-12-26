// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MysteryMasks is ERC721, Ownable {
    
    uint256 private _nextTokenId;
    
    uint256 public constant MINT_PRICE = 0.1 ether;
    uint256 public constant MAX_NFT_SUPPLY = 1000;
    uint256 public constant MAX_MINT_PER_TX = 20;
    
    bool public mintingActive = true;
    mapping(uint256 => bool) public hasSpecialPower;
    
    constructor() ERC721("MysteryMasks", "MASK") Ownable(msg.sender) {}
    
    function mintMask(uint256 numberOfMasks) external payable {
        require(mintingActive, "Minting is not active");
        require(numberOfMasks > 0 && numberOfMasks <= MAX_MINT_PER_TX, "Invalid number of masks");
        require(msg.value == MINT_PRICE * numberOfMasks, "Incorrect payment amount");
        require(_nextTokenId + numberOfMasks <= MAX_NFT_SUPPLY, "Would exceed max supply");
        
        for(uint256 i = 0; i < numberOfMasks; i++) {
            uint256 newTokenId = _nextTokenId + 1;
            
            // Randomly assign special powers
            if(block.timestamp % 2 == 0) {
                hasSpecialPower[newTokenId] = true;
            }
            
            _safeMint(msg.sender, newTokenId);
        }
    }
    
    function withdrawFunds() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
    
    function toggleMinting() external onlyOwner {
        mintingActive = !mintingActive;
    }
}