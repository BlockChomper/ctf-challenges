# The DittoVulnerableVault Challenge

Welcome, aspiring blockchain security expert! You've been tasked with auditing a new DeFi protocol called DittoVault. The protocol claims to offer users a way to deposit their tokens and earn rewards through a unique trading mechanism. However, there are whispers in the crypto community that something might be off with its implementation.

## Background

DittoVault allows users to:
1. Deposit tokens into the vault
2. Execute trades with a special "discount" feature
3. Withdraw their tokens (hopefully with profits)

The vault has been live for a week, and five early adopters (addresses 0x1 to 0x5) have each deposited 100 ether worth of tokens.

## Your Mission

As a white hat hacker, your goal is to investigate the DittoVault smart contract and determine if there are any vulnerabilities that could be exploited. If you find a vulnerability, you need to demonstrate how it could be used to drain a significant portion of the vault's assets.

## Success Criteria

You'll be considered successful if you can:
1. Identify the vulnerability in the contract
2. Develop an exploit that allows you to profit more than 25% of the initial total supply

## Tools at Your Disposal

- The full source code of the DittoVault contract
- A test environment where you can interact with the contract
- Your knowledge of Solidity and DeFi vulnerabilities

## Ethical Considerations

Remember, this is a controlled environment for educational purposes. In the real world, always disclose vulnerabilities responsibly and never exploit them for personal gain.

## Hint

Pay close attention to how fees are calculated and distributed in the `executeTrade` function. There might be a way to manipulate this mechanism to your advantage.

Good luck, and happy hacking!