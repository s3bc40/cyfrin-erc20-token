// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {OurToken} from "src/OurToken.sol";
import {DeployOurToken} from "script/DeployOurToken.s.sol";

contract OurTokenTest is Test {
    OurToken public ourToken;
    DeployOurToken public deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        vm.prank(msg.sender);
        ourToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public view {
        assertEq(STARTING_BALANCE, ourToken.balanceOf(bob));
    }

    function testAllowances() public {
        // Arrange
        uint256 intialAllowance = 1000;

        // Act
        // Bob approves Alice to spend tokens on her behalf
        vm.prank(bob);
        ourToken.approve(alice, intialAllowance);
        // Alice then take half of allowance
        uint256 tranferAmount = 500;
        vm.prank(alice);
        ourToken.transferFrom(bob, alice, tranferAmount);

        // Assert
        assertEq(ourToken.balanceOf(alice), tranferAmount);
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE - tranferAmount);
    }
}
