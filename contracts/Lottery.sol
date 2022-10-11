// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
contract Lottery Ownable {
    address payable[] public players;
    uint256 public usdEntryFee;
    AggregatorV3Interface internal ethUsdPriceFeed;
    enum LOTTERY_STATE {
        OPEN, 
        CLOSED,
        CALCULATING_WINNER
    }
    // 0
    // 1
    // 2
    LOTTERY_STATE public lottery_state;



    constructor (address _priceFeeAddress) public {
        usdEntryFee = 50 * (10**18);
        ethUsdPriceFeed = AggregatorV3Interface(_priceFeeAddress);
        lottery_state = LOTTERY_STATE.CLOSED;
    }



    function enter() public payable {
        // 50 Dollars minimum
        //require();
        require(lottery_state == LOTTERY_STATE.OPEN);
        require(msg.value >= getEnteranceFee(), "Not Enough ETH");
        players.push(payable(msg.sender));
    }

    function getEnteranceFee() public view returns (uint256){
        (,int256 price,,,) = ethUsdPriceFeed.latestRoundData();
        uint256 adjustedPrice = uint256(price) * 10 ** 10; // 18 decimals
        // $50, $2000 / Eth
        // 50/2000
        // 50 * 10000 / 2000
        uint256 costToEnter = (usdEntryFee * 10**18) / adjustedPrice;
        return costToEnter;



    }

    function startLottery() public onlyOwner {
        require(lottery_state == LOTTERY_STATE.CLOSED, "Can't start a new lottery yet");
        lottery_state = LOTTERY_STATE.OPEN;
    }

    function endLottery() public {}

}