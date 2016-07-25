{ Icon, Progress } = antd

module.exports = MobileLearningSubjectsPosts = React.createClass
  getInitialState: ->
    my_post: @props.posts[1].children[0]

  render: ->
    <MobileLearningCenterSecondaryLayout 
      title='岗位要求'
      back_to='/mobile/learning-center/subjects'
    >
      <MyPost post={@state.my_post} />
      <h3>{@state.my_post.name} · 岗位通用知识要求</h3>
      <SubjectsTree
        subjects={@props.points}
        _filter={(x)-> x.of_my_post is true}
      />

    </MobileLearningCenterSecondaryLayout>


MyPost = React.createClass
  render: ->
    post = @props.post

    <div className='my-post shadow-card'>
      <div className='me'>
        <div className='avatar' />
        <div className='ct'>
          <div className='name'>宋亮</div>
          <div className='score'>
            <div className='learned'><Icon type='book' /> 已学内容：32</div>
            <div className='exp'><Icon type='share-alt' /> 经验贡献：141</div>
          </div>
        </div>
      </div>
      <div className='title'>我的岗位：{post.name}</div>
      <div className='desc'>{post.desc}</div>
      <div className='stat'>
        <div className='s s2'>
          <Icon type='message' /> 27
        </div>
        <div className='s s1'>
          <Icon type='team' /> 45
        </div>
      </div>
    </div>