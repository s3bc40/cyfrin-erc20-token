// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";

import {OurToken} from "src/OurToken.sol";

contract DeployOurToken is Script {
    // No helper config (network helper) needed since the token is available on all networks
    uint256 public constant TOKEN_SUPPLY = 1000 ether;

    function run() external returns (OurToken) {
        vm.startBroadcast();
        OurToken ot = new OurToken(TOKEN_SUPPLY);
        vm.stopBroadcast();
        return ot;
    }
}
