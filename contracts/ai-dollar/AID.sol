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
import { OFT } from "@layerzerolabs/lz-evm-oapp-v2/contracts/oft/OFT.sol";

// solhint-disable func-name-mixedcase

/**
 * @title AID
 */
contract AID is FiatTokenV2_2, OFT {

    /**
     * @notice Initialize the OFT functionality
     * @param _lzEndpoint The LayerZero endpoint address.
     * @param _admin The address of the admin.
     */
    function initializeOFT(address _lzEndpoint, address _admin) external {
        // solhint-disable-next-line reason-string
        require(
            owner() == msg.sender,
            "AID: Caller is not the owner"
        );
        OFT._initialize(_lzEndpoint, _admin);
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
        override
        whenNotPaused
        returns (uint256 amountSentLD, uint256 amountReceivedLD)
    {
        return super._debit(_from, _amountLD, _minAmountLD, _dstEid);
    }

    // override to allow pausing
    function _credit(
        address _to,
        uint256 _amountLD,
        uint32 _srcEid
    ) internal override whenNotPaused returns (uint256 amountReceivedLD) {
        return super._credit(_to, _amountLD, _srcEid);
    }
}
