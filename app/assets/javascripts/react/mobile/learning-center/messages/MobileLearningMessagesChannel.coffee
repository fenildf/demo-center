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
          title={@props.messages?.channel?.name}
          desc={@props.messages?.channel?.desc}
        />
      </ChatBox>
    </MobileLearningCenterChatLayout>