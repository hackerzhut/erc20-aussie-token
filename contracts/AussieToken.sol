pragma solidity ^0.4.24;

import "./ERC20.sol";
import "./SafeMath.sol";

contract AussieToken is ERC20 {
    
    //For overflow/underflow errors
    using SafeMath for uint256;

    string public constant symbol = "OZ";
    string public constant name   = "Aussie Token";
    // same as ethereum
    uint8  public constant decimals = 18;
    
    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) internal allowed;

    uint256 public constant INITIAL_SUPPLY = 10000 * (10 ** uint256(decimals));
    uint256 _totalSupply;

    constructor() public {
        _totalSupply = INITIAL_SUPPLY;
        balances[msg.sender] = INITIAL_SUPPLY;
        emit Transfer(address(0), msg.sender, INITIAL_SUPPLY);
    }

    /**
    * @dev Total number of tokens in existence
    */
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /**
    * @dev Transfer token for a given address
    * @param _to The address to transfer the tokens
    * @param _value  The amount to be transferred to the _to address
    */

    function transfer(address _to, uint256 _value) public returns(bool) {
        require(_to != address(0));
        require(balances[msg.sender] >= _value);

        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    /**
    * @dev Gets the balance of the given user
    * @param _owner The address of the user
    * @return Amount of Aussie Tokens owned by the user in uint256
    */
    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    /**
     * @dev Transfers tokens from a _from address to _to address given a value
     * @param _from The address from which value is taken
     * @param _to The address to which value transferred value
     * @param _value The exact value that needs to be transferred
     * @return Boolean stating the transfer is success or not
     */
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(_to != address(0));
        require(balances[_from] >= _value);
        require(allowed[_from][msg.sender] >= _value);

        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        emit Transfer(_from, _to, _value);
        return true;
    }

    /**
    * @dev Approves the passed address to spend the specified amount of tokens on behalf of msg.sender.
    * @param _spender The address of the user which will spend the funds.
    * @param _value The amount of tokens to be spent by the approved user.
   */
    function approve(address _spender, uint256 _value) public returns (bool) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    /**
    * @dev Checks the amount of tokens that an owner has allowed a user to spend.
    * @param _owner address User's address which owns the funds.
    * @param _spender address Approved user's address which will spend the funds.
    * @return Amount of tokens still available for the spender to spend in uint256.
   */
    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowed[_owner][_spender];
    }

}