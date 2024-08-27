In a properly implemented ERC-4626 vault:

1. The ratio between total assets and total shares should remain constant, except when altered by deposit fees or yield accrual.
2. The `previewDeposit` function should calculate shares based on the current asset-to-share ratio.
3. This ratio should be used to maintain fairness between depositors who enter the vault at different times.

## The Vulnerability

In our VulnerableVault, the `previewDeposit` function is implemented as:

```solidity
function previewDeposit(uint256 assets) public view virtual returns (uint256) {
    return assets;
}
```

This implementation always returns the same number of shares as assets, regardless of the current state of the vault. This creates two major issues:

1. It breaks the constant asset-to-share ratio principle.
2. It allows for manipulation of the exchange rate between assets and shares.

## Exploitation Mechanism

The vulnerability can be exploited through the following steps:

1. An attacker deposits a small amount of assets, receiving an equal amount of shares.
2. The attacker then transfers a large amount of assets directly to the vault without minting new shares. This can be done by simply transferring tokens to the vault's address.
3. Now, the total assets in the vault have increased, but the total shares remain the same.
4. When the attacker withdraws their shares, they receive a disproportionately large amount of assets, based on the new, manipulated asset-to-share ratio.

## Mathematical Representation

Let's represent this mathematically:

1. Initial state: 
   - Total Assets (TA) = 1000
   - Total Shares (TS) = 1000
   - Ratio (R) = TA / TS = 1

2. Attacker deposits 1 asset:
   - TA = 1001
   - TS = 1001
   - R ≈ 1

3. Attacker transfers 9000 assets directly to vault:
   - TA = 10001
   - TS = 1001
   - R ≈ 10

4. Attacker withdraws 1 share:
   - Assets received = 1 * (10001 / 1001) ≈ 10

Thus, the attacker has turned 1 asset into 10 assets, draining value from other depositors.

## Correct Implementation

A correct implementation would maintain the asset-to-share ratio. For example:

```solidity
function previewDeposit(uint256 assets) public view virtual returns (uint256) {
    uint256 supply = totalSupply();
    return (supply == 0) ? assets : assets.mulDiv(supply, totalAssets(), Math.Rounding.Down);
}
```

This ensures that the number of shares minted is proportional to the current asset-to-share ratio, preventing the kind of manipulation our vulnerable implementation allows.