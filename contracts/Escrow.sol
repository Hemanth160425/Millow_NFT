//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface IERC721 {
    function transferFrom(
        address _from,
        address _to,
        uint256 _id
    ) external;
}

contract Escrow {
    address public nftAddress;
    address payable public seller;
    address public inspector; 
    address public lender;

    mapping(uint256 => bool) public isListed;
    mapping(uint256 => address) public buyer;
    mapping(uint256 => uint256) public purchasePrice;
    mapping(uint256 => uint256) public escrowAmount;
    mapping(uint256 => bool) public inspectionPassed; 
    mapping(uint256=> mapping(address=> bool)) public approval;


    modifier onlyseller() {
        require(msg.sender == seller , "Not seller");
        _;
    }
    modifier onlyBuyer(uint256 _nftID) {
        require(msg.sender == buyer[_nftID] , "Not buyer");
        _;
    }
    modifier onlyInspection() {
        require(msg.sender == inspector , "Not inspector");
        _;
    }
 

    constructor(address _nftAddress, address payable _seller, address _inspector,  address _lender) {
        nftAddress = _nftAddress;
        seller = _seller;
        inspector = _inspector;
        lender = _lender;
    }

    function list(uint256 _nftID ,
     address _buyer ,
      uint256 _purchasePrice ,
       uint256 _escrowAmount) public payable onlyseller() {
       
        IERC721(nftAddress).transferFrom(msg.sender , address(this) , _nftID);
        isListed[_nftID] = true;
        buyer[_nftID] = _buyer;
        purchasePrice[_nftID] = _purchasePrice;
        escrowAmount[_nftID] = _escrowAmount;
    }
    function depositEarnest(uint256 _nftID) public payable onlyBuyer(_nftID){
        require(isListed[_nftID] , "Property is not listed");
        require(msg.value >= escrowAmount[_nftID] , "Not enough escrow amount");
    }
    function updateInspectionStatus(uint256 _nftID , bool _passed) public onlyInspection{
        inspectionPassed[_nftID] = _passed;
    }

    function approvalSale(uint256 _nftID) public  {
        approval[_nftID][msg.sender] = true;
    } 

    receive() external payable {}

    function getBalance() public view returns(uint256) {
        return address(this).balance;
    }

    function finalizeSale(uint256 _nftID) public {
        require(approval[_nftID][buyer[_nftID]], "Buyer must approve");
        require(approval[_nftID][seller], "Seller must approve");
        require(approval[_nftID][inspector], "Inspector must approve");
        require(approval[_nftID][lender], "Lender must approve");
        require(inspectionPassed[_nftID], "Inspection must pass");
        require(address(this).balance >= purchasePrice[_nftID], "Not enough ether in contract");
        
        isListed[_nftID] = false; 
        
        // Pay Lender
        (bool success, ) = payable(lender).call{value: escrowAmount[_nftID]}("");
        require(success, "Failed to send funds to lender");

        // Pay Seller
        (success, ) = payable(seller).call{value: purchasePrice[_nftID] - escrowAmount[_nftID]}("");
        require(success, "Failed to send funds to seller");

        // Pay Inspector
        (success, ) = payable(inspector).call{value: address(this).balance}("");
        require(success, "Failed to pay inspector");

        // Transfer NFT to buyer
        IERC721(nftAddress).transferFrom(address(this), buyer[_nftID], _nftID);
    }

    function cancelSale(uint256 _nftID) public {
       if(inspectionPassed[_nftID] == false) {
           payable(buyer[_nftID]).transfer(address(this).balance);
       }
       else {
           payable(seller).transfer(address(this).balance);
       }
    }
}
