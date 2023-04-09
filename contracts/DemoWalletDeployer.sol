pragma solidity ^0.8.12;

import "./DemoWallet.sol";

/**
 * a sampler deployer contract for SimpleWallet
 * the "initCode" for a wallet hold its address and a method call (deployWallet) with parameters, not actual constructor code.
 */
contract DemoWalletDeployer {
    function deployWallet(
        IEntryPoint entryPoint,
        address owner,
        uint256 salt
    ) public returns (DemoWallet) {
        return
            new DemoWallet{salt: bytes32(salt)}(
                entryPoint,
                owner
            );
    }

    function getDeploymentAddress(
        IEntryPoint entryPoint,
        address owner,
        uint256 salt
    ) public view returns (address) {
        address predictedAddress = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            bytes1(0xff),
                            address(this),
                            salt,
                            keccak256(
                                abi.encodePacked(
                                    type(MyWallet).creationCode,
                                    abi.encode(
                                        entryPoint,
                                        owner                                 )
                                )
                            )
                        )
                    )
                )
            )
        );

        return predictedAddress;
    }
}