module.exports = MobileLearningMessagesUpdating = React.createClass
  render: ->
    <MobileLearningCenterChatLayout 
      title='# 更新消息推送'
      back_to='/mobile/learning-center/messages'
    >
      <ChatBox
        talkers={@props.talkers}
        messages={@props.messages} 
      >
        <ChatBox.Theme title='# 更新消息推送' desc='通过这个频道接收学习计划的更新消息，以及最新的推荐内容。' />
      </ChatBox>
    </MobileLearningCenterChatLayout>