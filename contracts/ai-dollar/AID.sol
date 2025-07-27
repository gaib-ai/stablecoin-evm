/**
 * Copyright 2023 Circle Internet Group, Inc. All rights reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

pragma solidity 0.6.12;

import { FiatTokenV2_2 } from "./v2/FiatTokenV2_2.sol";
import { OFTCoreUpgradeable } from "@layerzerolabs/oft-evm-upgradeable/contracts/oft/OFTCoreUpgradeable.sol";

// solhint-disable func-name-mixedcase

/**
 * @title AID
 */
contract AID is FiatTokenV2_2, OFTCoreUpgradeable {

    constructor(address _lzEndpoint) public OFTCoreUpgradeable(6, _lzEndpoint) {}

    /**
     * @notice Initialize the OFT functionality
     * @param _admin The address of the admin.
     */
    function __OFT_init(address _admin) external {
        // solhint-disable-next-line reason-string
        require(
            owner() == msg.sender,
            "AID: Caller is not the owner"
        );
        __OFTCore_init(_admin);
    }

    function sharedDecimals() public override pure returns (uint8) {
        return 6;
    }

    // override to allow pausing
    function _debit(
        address _from,
        uint256 _amountLD,
        uint256 _minAmountLD,
        uint32 _dstEid
    )
        internal
        override(OFTCoreUpgradeable)
        whenNotPaused
        returns (uint256 amountSentLD, uint256 amountReceivedLD)
    {
        (amountSentLD, amountReceivedLD) = _debitView(_amountLD, _minAmountLD, _dstEid);
        _burn(_from, amountSentLD);
    }

    // override to allow pausing
    function _credit(
        address _to,
        uint256 _amountLD,
        uint32 _srcEid
    ) internal override(OFTCoreUpgradeable) whenNotPaused returns (uint256 amountReceivedLD) {
        _mint(_to, _amountLD);
        return _amountLD;
    }
}
