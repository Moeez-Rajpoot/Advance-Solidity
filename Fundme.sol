// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract Fundme {

   uint256 constant MinimumUSD = 5 * 1e18;
   address payable  immutable Owner;
   mapping (address => uint256) public fundAmt;

   modifier onlyOwner{ 
    require(msg.sender == Owner , "Not Authenticated"); 
        _;
     }
    constructor(){
      Owner = payable(msg.sender);
        
    }

    function Fund() external  payable    {
        require(GetConvertion(msg.value) >= MinimumUSD , "Minimum USD for Fund is 5$");
        fundAmt[msg.sender] = fundAmt[msg.sender] + msg.value;
        
    }

    function WithDraw() external onlyOwner {
      
        require( address(this).balance > 0, "No amount to withDraw");
        (bool sent ,) = Owner.call{value : address(this).balance }("");
        require(sent , "Fail To Send");
    }


    function GetPrice() public view returns (uint256) {
        AggregatorV3Interface EthPriceUSD = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 PriceUSD, , ,)  = EthPriceUSD.latestRoundData();
        //2000.00000000
        return uint256(PriceUSD * 1e10);
        //2000.000000000000000000
    }

    function GetConvertion(uint256 _Amount) public view returns(uint256) {
        uint256 EthPrice = GetPrice();
        uint256 Value = (EthPrice * _Amount )/1e18;
        //2000.000000000000000000
        return Value;
        
    }


    
}