module.exports = MobileLearningMessagesChannel = React.createClass
  render: ->
    <MobileLearningCenterChatLayout 
      title={@props.messages?.channel?.name}
      back_to='/mobile/learning-center/messages'
    >
      <ChatBox
        talkers={@props.talkers}
        messages={@props.messages} 
      >
        <ChatBox.Theme 
          channel={@props.messages?.channel}
        />
      </ChatBox>
    </MobileLearningCenterChatLayout>