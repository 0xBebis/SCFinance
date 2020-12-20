pragma solidity ^0.7.0;

contract MVP {

  /**
   * @dev each party will fill out their half of the struct contract * below.
   *
   * Properties will be updated as the contract moves through
   * the system.
   */

  uint public length;

  struct Contract {
    address seller;
    uint orderID;
    uint pricePerUnit;
    string orderDetail;
    address buyer;
    uint totalCost;
    bool processing;
    bool complete;
  }

  mapping (uint => Contract) contractsByID;
  mapping (address => uint) userCredit;
  mapping (address => uint) userDebt;

  event newContract()

  function newContract(uint _price, string memory _detail) public {
    _id = length++;
    contractsByID[_id] = Contract(msg.sender, orderID, _price, _detail, address(0), 0, false, false);
  }

  function order(uint _id, uint _units) public {
    require (contractsByID[_id] != Contract(0), "MVP::order: contract does not exist");
    uint _total = contractsByID[_id].unitCost*_units;
    contractsByID[_id].totalCost = _total;
    contractsByID[_id].buyer = msg.sender;
  }

  function accept(uint _id) public {
    require (msg.sender == contractsByID[_id], "MVP::accept: must be seller");
    require (contractsByID[_id] != Contract(0), "MVP::accept: contract does not exist");
    
  }


}
