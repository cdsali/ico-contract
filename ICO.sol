// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ICO is Ownable {
    IERC20 public token;
    uint256 public startTime;
    uint256 public endTime;
    uint256 public rate;
    uint256 public minContribution;
    uint256 public maxContribution;

    mapping(address => uint256) public contributions;

    event TokensPurchased(address indexed buyer, uint256 amount);
    event ICOParametersUpdated(uint256 startTime, uint256 endTime, uint256 rate, uint256 minContribution, uint256 maxContribution);

    constructor(
        address tokenAddress,
        uint256 _startTime,
        uint256 _endTime,
        uint256 _rate,
        uint256 _minContribution,
        uint256 _maxContribution
    ) Ownable(msg.sender) { // Pass msg sendr to ownable constr
        token = IERC20(tokenAddress);
        startTime = _startTime;
        endTime = _endTime;
        rate = _rate;
        minContribution = _minContribution;
        maxContribution = _maxContribution;
    }
/*
    modifier icoActive() {
       // require(block.timestamp >= startTime && block.timestamp <= endTime, "ICO: Not active");
      //  _;
    }*/

    function buyTokens() external payable 
    //icoActive 
    {
        require(msg.value >= minContribution, "ICO: Contribution too low");
        require(msg.value <= maxContribution, "ICO: Contribution too high");

        uint256 tokenAmount = msg.value * rate;
        require(token.balanceOf(address(this)) >= tokenAmount, "ICO: Not enough tokens available");

        contributions[msg.sender] += msg.value;
        token.transfer(msg.sender, tokenAmount);

        emit TokensPurchased(msg.sender, tokenAmount);
    }

    function withdrawFunds() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    function withdrawUnsoldTokens() external onlyOwner {
        uint256 unsoldTokens = token.balanceOf(address(this));
        token.transfer(owner(), unsoldTokens);
    }

    function updateICOParameters(
        uint256 _startTime,
        uint256 _endTime,
        uint256 _rate,
        uint256 _minContribution,
        uint256 _maxContribution
    ) external onlyOwner {
        startTime = _startTime;
        endTime = _endTime;
        rate = _rate;
        minContribution = _minContribution;
        maxContribution = _maxContribution;

        emit ICOParametersUpdated(_startTime, _endTime, _rate, _minContribution, _maxContribution);
    }
}
