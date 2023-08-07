// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract Auction {
    event Start();
    event End(address highestBidder, uint highestBid);
    event Bid(address sender, uint amount);
    event Withdraw(address bidder, uint amount);

    // the one who wants to start the auction
    address payable public seller;

    bool public started;
    bool public ended;
    uint public endAt;

    // to record the current highest bid
    uint public highestBid;
    // to record the bidder of current highest bid
    address public highestBidder;
    // to record the bid information
    mapping(address => uint) public bids;

    constructor() {
        seller = payable(msg.sender);
    }

    function start(uint startingBid) external {
        // only when the auction is not started
        require(!started, "Already started!");
        // only seller can start the auction
        require(msg.sender == seller, "Only seller can start!");
        highestBid = startingBid;

        started = true;
        // the auction lasts for 60 seconds
        endAt = block.timestamp + 60;

        emit Start();
    }

    function bid() external payable {
        // bidder can bid only when auction is started
        require(started, "Not started!");
        // bidder can bid only when auction is not ended
        require(block.timestamp < endAt, "Ended!");
        // bidder can bid only when the bid is higher than current highest bid
        require(msg.value > highestBid);

        if (highestBidder != address(0)) {
            // store the bid imformation, when the bidders' bids lower than
            // current highest bid, they can withdraw their money back accordingly
            bids[highestBidder] += highestBid;
        }

        // update the current highest bidder and highest bid
        highestBid = msg.value;
        highestBidder = msg.sender;

        emit Bid(highestBidder, highestBid);
    }

    function withdraw() external payable {
        uint balance = bids[msg.sender];
        // clear the balance when the bidder withdraw their money, which can
        // prevent the reentrancy problem.
        bids[msg.sender] = 0;

        (bool sent, bytes memory data) = payable(msg.sender).call{
            value: balance
        }(""); // withdraw
        require(sent, "Could not withdraw");

        emit Withdraw(msg.sender, balance);
    }

    function end() external {
        // Auction can be ended only when auction is started
        require(started, "You need to start first");
        // Auction can be ended only when auction time ended
        require(block.timestamp >= endAt, "Auction is still ongoing!");
        // Auction can be ended only when auction is not ended
        require(!ended, "Auction is allready ended!");

        // when auction is ended, send the money to seller
        // if no one bids, then we don't need to send money to seller
        if (highestBidder != address(0)) {
            (bool sent, bytes memory data) = seller.call{value: highestBid}("");
            require(sent, "Could not pay seller");
        }

        ended = true;
        emit End(highestBidder, highestBid);
    }
}
