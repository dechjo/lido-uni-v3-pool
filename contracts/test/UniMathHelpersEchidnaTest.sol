// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

import '../libraries/UniMathHelpers.sol';

contract UniMathHelpersEchidnaTest {
    address constant FIRST = 0x0000000000000000000000000000000000000001;
    address constant SECOND = 0x0000000000000000000000000000000000000002;
    uint256 constant PRECISION = 1 << 192; // square of Q64.96 type
    
    function checkGetQuoteFromSqrt(
        uint160 sqrtRatioX96,
        uint128 baseAmount,
        bool tokensOrder
    ) public pure {
        uint256 res = UniMathHelpers.getQuoteFromSqrt(sqrtRatioX96, baseAmount, tokensOrder ? FIRST : SECOND, tokensOrder ? SECOND : FIRST);

        uint256 ratioX192 = uint256(sqrtRatioX96) * sqrtRatioX96;
        if (tokensOrder) {
            assert(res == ratioX192 * baseAmount / PRECISION);
        } else {
            assert(res == uint256(baseAmount) * PRECISION / ratioX192);
        }
    }
}
