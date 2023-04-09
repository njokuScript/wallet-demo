pragma solidity ^0.8.19;

import "@account-abstraction/contracts/core/BaseAccount.sol";

contract DemoWallet is BaseAccount {
using UserOperationLib for UserOperation;
}
