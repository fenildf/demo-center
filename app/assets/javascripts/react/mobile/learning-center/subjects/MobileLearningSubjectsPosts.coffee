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
      <h3>岗位知识要求</h3>
      <MyPostSubjectsTree subjects={@props.points} />
    </MobileLearningCenterSecondaryLayout>


MyPost = React.createClass
  render: ->
    post = @props.post

    <div className='my-post shadow-card'>
      <div className='me'>
        <div className='avatar' />
        <div className='ct'>
          <div className='name'>王小峰</div>
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


MyPostSubjectsTree = React.createClass
  render: ->
    subjects = @props.subjects.filter (x)-> x.of_my_post is true

    <div className='subjects-tree'>
    {
      for subject in subjects
        <Subject key={subject.id} subject={subject} />
    }
    </div>

Subject = React.createClass
  render: ->
    subject = @props.subject
    subjects = (@props.subject.children || []).filter (x)-> x.of_my_post is true
    url = "/mobile/learning-center/subjects/outline##{subject.id}"

    <div className='subject'>
      <a className='info shadow-card' href={url}>
        <Icon type='pay-circle-o' className='icc'/>
        <div className='ct'>
          <div className='title'>{subject.name}</div>
          <div className='progress'>
            <Progress percent={66} />
          </div>
        </div>
      </a>
      <div className='children'>
      {
        for subject in subjects
          <Subject key={subject.id} subject={subject} />
      }
      </div>
    </div>