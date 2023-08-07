// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./Auction.sol";
import "./DutchAuction.sol";

contract AuctionFactory {
    struct AuctionInfo {
        Auction auction;
        bool isDutch;
    }

    AuctionInfo[] public auctions;

    // initialize English auction
    function createAuction() public {
        Auction auction = new Auction();
        auctions.push(AuctionInfo({auction: auction, isDutch: false}));
    }

    // initialize Dutch auction
    function createDutchAuction(uint256 _startPrice, uint256 _reservePrice, uint256 _priceDrop) public {
        DutchAuction dutchAuction = new DutchAuction(_startPrice, _reservePrice, _priceDrop);
        auctions.push(AuctionInfo({auction: Auction(address(dutchAuction)), isDutch: true}));
    }

    // start Engilsh auction
    function start(uint index, uint startingBid) public {
        require(!auctions[index].isDutch, "This is a Dutch auction.");
        auctions[index].auction.start(startingBid);
    }

    // bid English
    function bid(uint index) public payable {
        auctions[index].auction.bid{value: msg.value}();
    }

    // withdraw English
    function withdraw(uint index) public payable {
        auctions[index].auction.withdraw();
    }

    // end English
    function end(uint index) public {
        auctions[index].auction.end();
    }

    // start Dutch
    function startDutchAuction(uint index) public {
        require(auctions[index].isDutch, "This is not a Dutch auction.");
        DutchAuction(address(auctions[index].auction)).startAuction();
    }

    // bid Dutch
    function bidDutchAuction(uint index) public payable {
        require(auctions[index].isDutch, "This is not a Dutch auction.");
        DutchAuction(address(auctions[index].auction)).bid{value: msg.value}();
    }

    // end Dutch
    function endDutchAuction(uint index) public {
        require(auctions[index].isDutch, "This is not a Dutch auction.");
        DutchAuction(address(auctions[index].auction)).endAuction();
    }

    // auction state Dutch
    function getAuctionState(uint index) public view returns (uint256) {
        require(auctions[index].isDutch, "This is not a Dutch auction.");
        return DutchAuction(address(auctions[index].auction)).getAuctionState();
    }

    // auction price Dutch
    function getCurrentPrice(uint index) public view returns (uint256) {
        require(auctions[index].isDutch, "This is not a Dutch auction.");
        return DutchAuction(address(auctions[index].auction)).getCurrentPrice();
    }
}
