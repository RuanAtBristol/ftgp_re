// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract DutchAuction {
    address public seller;
    uint256 public startPrice;
    uint256 public reservePrice;
    uint256 public priceDrop;
    uint256 public constant duration = 60; // Fixed duration of 60 seconds
    uint256 public startTime;
    uint256 public endTime;
    bool public auctionEnded;
    address public winningBidder;
    uint256 public winningPrice;

    // Events
    event AuctionStarted(uint256 startTime, uint256 endTime);
    event BidPlaced(address indexed bidder, uint256 amount);
    event AuctionEnded(address indexed winner, uint256 finalPrice);

    modifier onlySeller() {
        require(msg.sender == seller, "You are not the seller");
        _;
    }

    modifier auctionNotEnded() {
        require(!auctionEnded, "Auction already ended");
        _;
    }

    constructor(
        uint256 _startPrice,
        uint256 _reservePrice,
        uint256 _priceDrop
    ) {
        seller = msg.sender;
        startPrice = _startPrice;
        reservePrice = _reservePrice;
        priceDrop = _priceDrop;
    }

    function startAuction() public onlySeller {
        startTime = block.timestamp;
        endTime = startTime + duration;
        emit AuctionStarted(startTime, endTime);
    }

    function bid() public payable auctionNotEnded {
        require(block.timestamp <= endTime, "Auction time has ended");
        uint256 elapsedTime = block.timestamp - startTime;
        uint256 currentPrice = startPrice - (elapsedTime * priceDrop);

        require(
            msg.value >= currentPrice,
            "Bid must be at least the current price"
        );

        if (msg.value >= currentPrice && currentPrice >= reservePrice) {
            // End the auction if a valid bid is made
            auctionEnded = true;
            winningBidder = msg.sender;
            winningPrice = currentPrice;
            emit BidPlaced(msg.sender, msg.value);
        }
    }

    function endAuction() public onlySeller {
        require(
            auctionEnded || block.timestamp > endTime,
            "Auction has not ended yet"
        );
        require(!auctionEnded, "Auction has already been ended");

        auctionEnded = true;
        emit AuctionEnded(winningBidder, winningPrice);

        // Send the funds to the seller
        payable(seller).transfer(winningPrice);
    }

    function getAuctionState() public view returns (uint256) {
        if (auctionEnded) return 0; // Ended
        if (block.timestamp < startTime) return 1; // Not started
        if (block.timestamp >= startTime && block.timestamp <= endTime)
            return 2; // In progress
        return 3; // Time ended without any bids
    }

    function getCurrentPrice() public view returns (uint256) {
        if (block.timestamp < startTime || block.timestamp > endTime) {
            return 0;
        }
        uint256 elapsedTime = block.timestamp - startTime;
        return startPrice - (elapsedTime * priceDrop);
    }
}
