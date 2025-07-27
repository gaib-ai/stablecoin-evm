
pragma solidity 0.6.12;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

abstract contract AbstractFiatTokenV1 is IERC20 {
    function _approve(
        address owner,
        address spender,
        uint256 value
    ) internal virtual;

    function _transfer(
        address from,
        address to,
        uint256 value
    ) internal virtual;
}