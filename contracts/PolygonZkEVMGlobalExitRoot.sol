// SPDX-License-Identifier: AGPL-3.0

pragma solidity 0.8.20;

import "./interfaces/IPolygonZkEVMGlobalExitRoot.sol";
import "./lib/GlobalExitRootLib.sol";

/**
 * Contract responsible for managing the exit roots across multiple networks
 */
contract PolygonZkEVMGlobalExitRoot is IPolygonZkEVMGlobalExitRoot {
    // PolygonZkEVMBridge address
    address public immutable bridgeAddress;

    // Rollup contract address
    address public immutable rollupAddress;

    // Rollup exit root, this will be updated every time a batch is verified
    bytes32 public lastRollupExitRoot;

    // Mainnet exit root, this will be updated every time a deposit is made in mainnet
    bytes32 public lastMainnetExitRoot;

    // Store every global exit root: Root --> timestamp
    mapping(bytes32 => uint256) public globalExitRootMap;

    /**
     * @dev Emitted when the global exit root is updated
     */
    event UpdateGlobalExitRoot(
        bytes32 indexed mainnetExitRoot,
        bytes32 indexed rollupExitRoot
    );

    /**
     * @param _rollupAddress Rollup contract address
     * @param _bridgeAddress PolygonZkEVMBridge contract address
     */
    constructor(address _rollupAddress, address _bridgeAddress) {
        rollupAddress = _rollupAddress;
        bridgeAddress = _bridgeAddress;
    }
}
