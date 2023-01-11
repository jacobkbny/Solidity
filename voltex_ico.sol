//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract voltex_ico{
    uint public max_voltex = 10000000;
    uint public usd_to_voltex = 1000;
    uint public total_voltex_bought = 0;

    mapping(address => uint) equity_voltex;
    mapping(address => uint) equity_usd;

    modifier can_buy_voltex (uint usd_invested){
        require(usd_invested * usd_to_voltex + total_voltex_bought <= max_voltex);
        _;
    }
    function equity_in_voltex(address investor) external view returns (uint){
        return equity_voltex[investor];
    }
    function equity_in_usd(address investor) external view returns (uint){
        return equity_usd[investor];
    }
    function buy_voltex(address investor, uint usd_invested) external
    can_buy_voltex(usd_invested){
        uint voltex_bought = usd_invested * usd_to_voltex;
        equity_voltex[investor] += voltex_bought;
        equity_usd[investor] = equity_voltex[investor]/1000;
        total_voltex_bought += voltex_bought;
    }
    function sell_voltex(address investor, uint voltex_sold) external{
        equity_voltex[investor] -= voltex_sold;
        equity_usd[investor] = equity_voltex[investor]/1000;
        total_voltex_bought -= voltex_sold;
    }
}

