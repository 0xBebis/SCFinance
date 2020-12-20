pragma solidity ^0.7.0;

contract SCFPrototype {

  /**
   * @dev each party will fill out their half of the struct contract * below.
   *
   * Properties will be updated as the contract moves through
   * the system.
   *
   * WARNING: This code is prototypal, and not suitable for a production environment.
   ********** Do not store valuable tokens in this contract.
   */

  uint public length;
  uint public totalLiquidity;
  uint private marginSum;

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
  mapping (address => uint) provision;

  event newContract();
  event newOrder();
  event orderAccepted();
  event orderClosed();

  /*//////////////////////////
  + Contract Implementations +
  //////////////////////////*/

  function new(uint _price, string memory _detail) public {
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
    require (msg.sender == contractsByID[_id].seller, "MVP::accept: must be seller");
    require (contractsByID[_id] != Contract(0), "MVP::accept: contract does not exist");
    address _buyer = contractsByID[_id].buyer;
    contractsByID[_id].processing = true;
    userCredit[msg.sender] = contractsByID[_id].totalCost; // adjust by %
    userDebt[_buyer] = contractsByID[_id].totalCost; // adjust by %
  }

  function close(uint _id) public {
    require (msg.sender == contractsByID[_id].seller, "MVP::close: must be seller");
    require (contractsByID[_id].processing, "MVP::close: please accept contract first");
    contractsByID[_id].complete = true;
    userCredit[msg.sender] = contractsByID[_id].totalCost;
  }

  /*///////////////////////////
  + Financial Implementations +
  ///////////////////////////*/

  function pay();
  // pay off debt

  function liquify();
  // provide funding

  function claim();
  // claim your share of fees generated




}
