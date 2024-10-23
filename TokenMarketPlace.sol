// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract TokenMarketPlace is Ownable {

using SafeERC20 for IERC20;
using SafeMath for uint256;

uint256 public tokenPrice = 2e16 wei; // 0.02 ether per GLD token
uint256 public sellerCount = 1;
uint256 public buyerCount=1;

IERC20 public gldToken;

event TokenPriceUpdated(uint256 newPrice);
event TokenBought(address indexed buyer, uint256 amount, uint256 totalCost);
event TokenSold(address indexed seller, uint256 amount, uint256 totalEarned);
event TokensWithdrawn(address indexed owner, uint256 amount);
event EtherWithdrawn(address indexed owner, uint256 amount);
event CalculateTokenPrice(uint256 priceToPay);


constructor(address _gldToken) Ownable(msg.sender) {
    gldToken = IERC20(_gldToken);
}


// Updated logic for token price calculation with safeguards
function adjustTokenPriceBasedOnDemand() public {
    uint marketDemandRatio = buyerCount.mul(1e18).div(sellerCount); 
    uint smoothingFactor = 1e18;
    uint adjustedRatio = marketDemandRatio.add(smoothingFactor).div(2);
    uint newTokenPrice =  tokenPrice.mul(adjustedRatio).div(1e18);
    uint minimumPrice = 2e16;
    if (newTokenPrice<minimumPrice){
        tokenPrice = minimumPrice;
    }
    tokenPrice = newTokenPrice;
   
}

// Buy tokens from the marketplace
function buyGLDToken(uint256 _amountOfToken) public payable {
   
}

function calculateTokenPrice(uint _amountOfToken) public {
    require(_amountOfToken>0,"Amount of Token Should Be Greater Than 0");
    adjustTokenPriceBasedOnDemand();
    uint amountToPay = _amountOfToken.mul(tokenPrice).div(1e18);

    
}

// Sell tokens back to the marketplace
function sellGLDToken(uint256 amountOfToken) public {
    // requ
}

// Owner can withdraw excess tokens from the contract
function withdrawTokens(uint256 amount) public onlyOwner {
   
}

// Owner can withdraw accumulated Ether from the contract
function withdrawEther(uint256 amount) public onlyOwner {
    
}
}