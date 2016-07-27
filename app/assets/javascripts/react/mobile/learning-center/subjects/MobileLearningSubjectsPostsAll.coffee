{ Icon } = antd

module.exports = MobileLearningSubjectsPostsAll = React.createClass
  render: ->
    <MobileLearningCenterSecondaryLayout 
      title='全部岗位要求'
      back_to='/mobile/learning-center/subjects/posts'
    >
      <Search placeholder='查找岗位信息' />

      <h3>全部岗位分类</h3>
      <div className='all-posts'>
        {
          for post, key in @props.posts
            <Post key={key} post={post} />
        }
      </div>
    </MobileLearningCenterSecondaryLayout>

Post = React.createClass
  render: ->
    <div>
      <div className='post shadow-card'>
        <div className='name'><Icon type='team' /> {@props.post.name}</div>
      </div>
      {
        if @props.post.children?
          <div className='children'>
          {
            for child, key in @props.post.children
              <a key={key} className='post shadow-card' href='/mobile/learning-center/subjects/posts'>
                <div className='name'><Icon type='team' /> {child.name}</div>
                <div className='desc'>{child.desc}</div>
              </a>
          }
          </div>
      }
    </div>