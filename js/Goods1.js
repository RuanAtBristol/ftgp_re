const productImg = document.querySelector("#productImg");
productNameEvent.addEventListener("click", function () {
  let value = productImg.value;
});


var button12 = document.getElementById("apple12");
var button24 = document.getElementById("apple24");
var appleImage = document.getElementById("appleImage");
var appleText = document.getElementById("appleText");
var sizeText = document.getElementById("sizeText");
var buyText = document.getElementById("p_buy");

// button12.addEventListener("click", function () {
//   appleImage.src = "apple_12.jpg";
//   appleText.textContent = " 12 Count";
//   sizeText.textContent = "12 Organic Honeycrisp Apples";
//   buyText.textContent = "You have selected 12-Count option, the price is ￡ 10";
// });

// button24.addEventListener("click", function () {
//   appleImage.src = "apple_24.jpg";
//   appleText.textContent = " 24 Count";
//   sizeText.textContent = "24 Organic Honeycrisp Apples";
//   buyText.textContent = "You have selected 24-Count option, the price is ￡ 18";
// });

function changeLink(value) {
  var link = document.getElementById("myLink");
  link.href = "index1.html?var1=value1&var2=" + value;
}

let productName = "";
let startPrice = "";
const productNameEvent = document.querySelector("#productName");
productNameEvent.addEventListener("input", function () {
  productName = upload.value;
});

const startPriceEvent = document.querySelector("#startingPrice");
productNameEvent.addEventListener("input", function () {
  startPrice = parseFloat(upload.value);
});

const upload = document.querySelector("#upload");
upload.addEventListener("click", function () {
  const newLi = document.createElement("li");
  const newA = document.createElement("a");
  const newImg = document.createElement("img");
  const newH3 = document.createElement("h3");
  const newP = document.createElement("P");
  const newSpan = document.createElement("span");

  newImg.src = "images/item1.png";
  newA.href = "Goods1.html";
  newH3.innerText =
    "product " +
    (document.getElementById("content").childNodes[0].childNodes.length + 1);
  newSpan.innerText = "Starting price " + startPrice + "ETH";
  newP.appendChild(newSpan);

  newA.appendChild(newImg);
  newA.appendChild(newH3);
  newA.appendChild(newP);
  newLi.appendChild(newA);
  document.getElementById("content").childNodes[0].appendChild;
});


document.addEventListener("DOMContentLoaded", () => {
  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const signer = provider.getSigner();

  const contractAddress = "0x522B5717ec7bB25FF9B0667181386831eF44047b";
  const abi = [
    {
      "inputs": [],
      "stateMutability": "nonpayable",
      "type": "constructor"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "internalType": "address",
          "name": "sender",
          "type": "address"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "amount",
          "type": "uint256"
        }
      ],
      "name": "Bid",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "internalType": "address",
          "name": "highestBidder",
          "type": "address"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "highestBid",
          "type": "uint256"
        }
      ],
      "name": "End",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [],
      "name": "Start",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "internalType": "address",
          "name": "bidder",
          "type": "address"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "amount",
          "type": "uint256"
        }
      ],
      "name": "Withdraw",
      "type": "event"
    },
    {
      "inputs": [],
      "name": "bid",
      "outputs": [],
      "stateMutability": "payable",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "name": "bids",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "end",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "endAt",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "ended",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "highestBid",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "highestBidder",
      "outputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "seller",
      "outputs": [
        {
          "internalType": "address payable",
          "name": "",
          "type": "address"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "startingBid",
          "type": "uint256"
        }
      ],
      "name": "start",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "started",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "withdraw",
      "outputs": [],
      "stateMutability": "payable",
      "type": "function"
    }
  ];

  const auctionContract = new ethers.Contract(contractAddress, abi, signer);

  const startForm = document.getElementById("start-form");
  startForm.addEventListener("submit", async (e) => {
    e.preventDefault();
    const startingBid = document.getElementById("startingBid").value;
    startingBid = 0.0000000002;
    try {
      await auctionContract.start(startingBid);
      console.log("Auction started successfully");
    } catch (err) {
      console.log("Error: ", err);
    }
  });

  const bidForm = document.getElementById("bid-form");
  bidForm.addEventListener("submit", async (e) => {
    e.preventDefault();
    const bidAmount = document.getElementById("bidAmount").value;
    try {
      await auctionContract.bid({ value: ethers.utils.parseEther(bidAmount) });
      console.log("Bid placed successfully");
    } catch (err) {
      console.log("Error: ", err);
    }
  });
});
