// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DittoVulnerableVault {
    mapping(address => uint256) public balances;
    uint256 public totalSupply;
    uint256 public constant DISCOUNT_THRESHOLD = 100 ether;
    uint256 public constant DISCOUNT_FEE_PERCENTAGE = 10; // 10% fee
    uint256 public initialTotalSupply;

    // Deposit tokens into the vault
    function deposit(uint256 amount) external {
        if (initialTotalSupply == 0) {
            initialTotalSupply = totalSupply + amount;
        }
        balances[msg.sender] += amount;
        totalSupply += amount;
    }

    // Withdraw tokens from the vault
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        totalSupply -= amount;
    }

    // Simulate a discounted trade
    function executeTrade(uint256 tradeAmount) external {
        require(tradeAmount <= DISCOUNT_THRESHOLD, "Trade too large");

        // Calculate fee based on total supply, not just the trade amount
        uint256 fee = (totalSupply * DISCOUNT_FEE_PERCENTAGE) / 100;

        // Mint new tokens as fee and add to total supply
        totalSupply += fee;

        // Distribute fee proportionally to all users
        for (uint256 i = 0; i < 5; i++) {
            address user = address(uint160(i + 1)); // Simplified user addresses
            uint256 userShare = (fee * balances[user]) / totalSupply;
            balances[user] += userShare;
        }
    }

    function checkVictory(address user, uint256 initialBalance, uint256 withdrawnAmount) external view returns (bool) {
        require(initialTotalSupply > 0, "Initial total supply not set");
        uint256 currentBalance = balances[user];
        uint256 totalProfit = (currentBalance + withdrawnAmount) - initialBalance;
        uint256 profitPercentage = (totalProfit * 100) / initialTotalSupply;
        return profitPercentage > 25; // Victory if profit > 25% of initial total supply
    }
}
