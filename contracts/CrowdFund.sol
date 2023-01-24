// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CrowdFund {

    struct Campaign {
        address creator;
        uint goal;
        uint pledged;
        uint32 startTime;
        uint32 endTime;
        bool claimed;
    }
    error InvalidStartTime(uint _startTime);
    error InvalidEndTime(uint _endTime);
    error ExceedMaxCampaignDuration(uint _maxDuration);
    
    event newCampaignLaunched(uint32 _startTime, uint32 _endTime, address _creator, uint _goal);
    // @dev support only one token
    IERC20 public token;
    // count: unique id for each campaign
    uint public count;
    mapping (uint => Campaign) public campaigns;
    // @dev how much amount of tokens has each user pledged to a campaign ?
    // CampaignId => userAddress => amount
    mapping(uint => mapping(address => uint)) public pledgedAmount;

    constructor(address _token) {
        token = IERC20(_token);
    }  
   /**
    * @dev launch(), allow a user to launch a new campaign
    */
   function launch(
    uint _goal,
    uint32 _startTime,
    uint32 _endTime
   ) external {
      if(_startTime < block.timestamp) {
        revert InvalidStartTime(_startTime);
      }
      if(_endTime < _startTime) {
        revert InvalidEndTime(_endTime);
      }
      if(_endTime > block.timestamp + 90 days){
        revert ExceedMaxCampaignDuration(block.timestamp + 90 days);
      } 
      count += 1;
      campaigns[count] = Campaign({
        creator: msg.sender,
        goal: _goal,
        pledged: 0,
        startTime: _startTime,
        endTime: _endTime,
        claimed: false
      });
    emit newCampaignLaunched(_startTime, _endTime, msg.sender, _goal);
   }

   /**
    * @dev cancel() allow a user to cancel a campaign
    * @dev param _id , the id of the campaign
    */
   function cancel(uint _id) external {

   }

   /**
    * @dev pledge() allow user to pledge for a campaign
    * param _id , the id of the campaign
    * param amount , the amount he wants to pledge
    */
   function pledge(uint _id, uint _amount) external {

   }

   /**
    * @dev unpledge() to unpledge
    */
   function unpledge(uint _id, uint _amount) external {

   }

   /**
    * @dev claim(), allow campaign creator to claim the tokens after the campaign
    */
   function claim(uint _id) external {

   }

   /**
    * @dev refund(), will refund users if the campaign does not reach it goal
    */
   function refund(uint _id) external {

   }
}
