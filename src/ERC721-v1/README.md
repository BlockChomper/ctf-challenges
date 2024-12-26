# The MysteryMasks Challenge

Welcome, blockchain security enthusiast! You've discovered a new NFT collection called MysteryMasks that's generating significant buzz in the crypto community. The project boasts "secure-by-design" mechanics using industry-standard OpenZeppelin contracts, but something about their minting implementation has caught your attention.

## Background

MysteryMasks offers:

1. A collection of unique NFT masks with random special powers
2. A fair minting system with a max of 20 masks per transaction
3. Each mask costs 0.1 ETH to mint
4. The collection has a hard cap of 1000 masks, and early minters have reported that masks minted during even-numbered timestamps have special powers.

## Your Mission

As a smart contract security researcher, your goal is to analyze the MysteryMasks contract for potential vulnerabilities. Initial code review suggests there might be a way to circumvent the transaction limits that are meant to ensure fair distribution.

## Success Criteria

You'll be considered successful if you can:
1. Finding a way to mint more than the maximum allowed masks (20) in a single transaction
2. Creating a working exploit contract that demonstrates the vulnerability
3. Successfully executing your exploit against the test contract

## Ethical Considerations

Remember, this is a controlled environment for educational purposes. In the real world, always disclose vulnerabilities responsibly and never exploit them for personal gain.

## Hint

"Safe" functions often make external calls. What happens during these calls, and how might this affect the contract's state management?

Good luck, and remember: understanding vulnerabilities is the first step to building more secure contracts!
