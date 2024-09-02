![Block logo](https://imgur.com/EvzXMnq.png)

## Rareskills Inspired CTF Challenges

**Test your whitehat skills in our range of challenges inspired from Rareskills educational content**

## Documentation

[Uniswap V2 Book](https://www.rareskills.io/uniswap-v2-book)

## Challenges

[Uniswap V2 Book Chapter 1: ERC4626 - Vulnerable Vault](https://github.com/BlockChomper/ctf-challenges/tree/master/src/ERC4626-v1)

## Setting up Challenge Environment

```jsx
git clone https://github.com/BlockChomper/ctf-challenges.git
```

Ensure you have Foundry installed with `foundryup` and then build the repo after cloning from Github

```jsx
forge build
```

- Select challenge from sub folder within SRC. 
- View associated readme.md for scenario details. 
- Analyse vulnerable contract.
- Write exploit code within matching test file for vulnerable contract.

Run exploit test to confirm successful completion of challenge 
```jsx
forge test --match-test testExploit
```
