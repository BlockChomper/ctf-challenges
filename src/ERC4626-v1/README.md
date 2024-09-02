# The Vulnerable Vault Challenge

## Background
A new decentralized finance (DeFi) protocol has emerged, promising high yields and secure asset management. At the heart of this protocol is the VulnerableVault, an implementation of the ERC-4626 Tokenized Vault Standard. The vault has quickly gained popularity, with many users eagerly depositing their hard-earned tokens.

## Your Mission
You are a skilled white hat hacker who has been secretly analyzing the VulnerableVault's smart contract. After days of scrutiny, you've discovered a critical vulnerability that could put all depositors' funds at risk. However, simply reporting the vulnerability might not be enough to convince the protocol's overconfident developers.

Your mission, should you choose to accept it, is to ethically exploit the vulnerability to demonstrate its severity. Your goal is to drain a significant portion of the vault's funds, specifically targeting a high-profile victim who recently deposited 10,000 tokens.

## Objectives
1. Exploit the vulnerability in the VulnerableVault contract.
2. Player should have gained more than 100 tokens (the token has 18 decimals).
3. Vault should have lost more than 100 tokens.
4. Complete the exploit in a single transaction (within the `testExploit` function).

## Resources at Your Disposal
- You start with 1,000 tokens in your wallet.
- You have full access to the VulnerableVault's source code.
- The vault currently holds 10,000 tokens deposited by the victim.

## Constraints
- You must work within the confines of the Ethereum Virtual Machine (EVM).
- You cannot modify the VulnerableVault contract itself.
- Your exploit must be executed through interactions with the vault's public interface.
- You may only use the `player` address in the test, you may not prank other addresses.

## Hints
- Pay close attention to the implementation of the deposit and withdraw functions.
- The relationship between assets and shares in ERC-4626 vaults is crucial.
- Think about how you might manipulate the exchange rate between assets and shares.

## Ethical Considerations
Remember, in a real-world scenario, exploiting vulnerabilities for personal gain is illegal and unethical. This challenge is a simulation designed to help you understand and prevent such vulnerabilities in the future.

Good luck, hacker. users are counting on you to expose this vulnerability before real malicious actors can exploit it!
