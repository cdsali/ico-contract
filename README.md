



This repository contains a Solidity smart contract for conducting an Initial Coin Offering (ICO). The ICO contract allows users to purchase tokens by sending Ether (ETH), manages contributions, and enables the contract owner to withdraw collected funds and unsold tokens. It uses the OpenZeppelin library for secure contract development.

## Features

- **Token Purchase**: Users can buy tokens by sending ETH, with defined minimum and maximum contribution limits.
- **Fund Withdrawal**: The contract owner can withdraw ETH collected from the ICO.
- **Unsold Tokens**: The contract owner can withdraw any unsold tokens after the ICO period.
- **ICO Parameters Update**: The owner can update ICO parameters, including start and end times, rate, and contribution limits.
- **Ownership Management**: Inherits from OpenZeppelin’s `Ownable` for secure contract ownership.

## Contract Details

### `ICO` Contract

- **Inherits From**: `Ownable`
- **Interfaces Used**: `IERC20`

### State Variables

- `IERC20 public token`: The token being sold in the ICO.
- `uint256 public startTime`: The start time of the ICO.
- `uint256 public endTime`: The end time of the ICO.
- `uint256 public rate`: The rate at which ETH is converted to tokens.
- `uint256 public minContribution`: Minimum ETH contribution required.
- `uint256 public maxContribution`: Maximum ETH contribution allowed.

### Functions

- **`constructor(address tokenAddress, uint256 _startTime, uint256 _endTime, uint256 _rate, uint256 _minContribution, uint256 _maxContribution)`**: Initializes the ICO with the token address and parameters.

- **`buyTokens()`**: Allows users to purchase tokens. Requires that the contribution is within the specified limits.

- **`withdrawFunds()`**: Allows the owner to withdraw all ETH collected from the ICO.

- **`withdrawUnsoldTokens()`**: Allows the owner to withdraw any tokens left unsold after the ICO.

- **`updateICOParameters(uint256 _startTime, uint256 _endTime, uint256 _rate, uint256 _minContribution, uint256 _maxContribution)`**: Allows the owner to update the ICO parameters.

### Events

- **`TokensPurchased(address indexed buyer, uint256 amount)`**: Emitted when tokens are purchased.
- **`ICOParametersUpdated(uint256 startTime, uint256 endTime, uint256 rate, uint256 minContribution, uint256 maxContribution)`**: Emitted when ICO parameters are updated.

## Usage

1. **Deploy the Contract**: Deploy the contract to an Ethereum network, passing the required constructor parameters.

2. **Interact with the Contract**:
   - Call `buyTokens()` to purchase tokens.
   - Use `withdrawFunds()` to collect ETH from the ICO.
   - Call `withdrawUnsoldTokens()` to reclaim any unsold tokens.
   - Update ICO parameters using `updateICOParameters()` as needed.

## Requirements

- Solidity ^0.8.18
- OpenZeppelin Contracts

## Installation

To install the dependencies, run:

```bash
npm install
```

## Testing

Run the test suite to ensure the contract works as expected:

```bash
npx hardhat test
```
