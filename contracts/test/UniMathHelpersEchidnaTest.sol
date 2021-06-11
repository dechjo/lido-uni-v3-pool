// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

import '../libraries/UniMathHelpers.sol';

contract UniMathHelpersEchidnaTest {
    address constant FIRST = 0x0000000000000000000000000000000000000001;
    address constant SECOND = 0x0000000000000000000000000000000000000002;
    uint256 constant PRECISION = 1 << 192; // square of Q64.96 type
    uint256 constant MASK = ~uint256(0xFF);

    function checkGetQuoteFromSqrt(
        uint160 sqrtRatioX96,
        uint128 baseAmount
    ) public pure {
        uint256 res = UniMathHelpers.getQuoteFromSqrt(sqrtRatioX96, baseAmount, FIRST, SECOND);

        uint256 ratioX128 = FullMath.mulDiv(sqrtRatioX96, sqrtRatioX96, 1 << 64);
        assert(res & MASK == FullMath.mulDiv(ratioX128, baseAmount, 1 << 128) & MASK);
    }

    function checkReverseGetQuoteFromSqrt(
        uint160 sqrtRatioX96,
        uint128 baseAmount
    ) public pure {
        uint256 res = UniMathHelpers.getQuoteFromSqrt(sqrtRatioX96, baseAmount, SECOND, FIRST);

        uint256 ratioX128 = FullMath.mulDiv(sqrtRatioX96, sqrtRatioX96, 1 << 64);
        assert(res & MASK == FullMath.mulDiv(baseAmount, 1 << 128, ratioX128) & MASK);
    }
}
