
pragma solidity 0.6.12;

import { FiatTokenV1 } from "../v1/FiatTokenV1.sol";
import { Rescuable } from "./Rescuable.sol";

/**
 * @title FiatTokenV1_1
 * @dev ERC20 Token backed by fiat reserves
 */
contract FiatTokenV1_1 is FiatTokenV1, Rescuable {

}