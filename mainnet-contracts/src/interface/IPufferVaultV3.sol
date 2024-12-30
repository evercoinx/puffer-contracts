// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

import { IPufferVaultV2 } from "./IPufferVaultV2.sol";

/**
 * @title IPufferVaultV3
 * @notice Interface for the PufferVault version 3 contract.
 * @custom:security-contact security@puffer.fi
 */
interface IPufferVaultV3 is IPufferVaultV2 {
    /**
     * @notice Constructor parameters for bridging.
     * @param xToken The address of the xToken contract.
     * @param lockBox The address of the lockBox contract.
     * @param l2RewardManager The address of the L2 reward manager.
     */
    struct BridgingConstructorParams {
        address xToken;
        address lockBox;
        address l2RewardManager;
    }

    /**
     * @notice Returns the total reward mint amount.
     * @return The total minted rewards amount.
     */
    function getTotalRewardMintAmount() external view returns (uint256);

    /**
     * @notice Returns the total reward mint amount.
     * @return The total deposited rewards amount.
     */
    function getTotalRewardDepositAmount() external view returns (uint256);

    function setGrantRoot(bytes32 grantRoot) external;

    function claimGrant(uint256 amount, bool isNativePayment, bytes32[] calldata proof) external;

    function getGrantInfo()
        external
        view
        returns (bytes32 root, uint256 maxAmount, uint256 epochStartTime, uint256 epochDuration);

    function getClaimableGrant(address grantee) external view returns (uint256 epoch, uint256 amount);

    function calculateGrantEpoch() external view returns (uint256);

    /**
     * @notice Emitted when the rewards are deposited to the PufferVault
     * @dev Signature "0x3a278b4e83c8793751d35f41b90435c742acf0dfdd54a8cbe09aa59720db93a5"
     */
    event UpdatedTotalRewardsAmount(
        uint256 previousTotalRewardsAmount, uint256 newTotalRewardsAmount, uint256 depositedETHAmount
    );

    event GrantRootSet(bytes32 grantRoot);

    event GrantPaid(address indexed grantee, uint256 indexed grantEpoch, uint256 amount, bool isNativePayment);

    error InvalidGrantAmount(uint256 amount);

    error IneligibleGrantee(address grantee);

    error UnavailableGrantAmount(uint256 requestedAmount, uint256 availableAmount);
}
