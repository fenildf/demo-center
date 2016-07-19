{ Icon } = antd

module.exports = MobileLearningCenter = React.createClass
  render: ->
    <MobileLearningCenterLayout title='个人面板'>
      <UserCard />
      <CustomCenterPage />
    </MobileLearningCenterLayout>

UserCard = React.createClass
  render: ->
    <div className='user-card shadow-card'>
      <div className='detail'>
        <div className='avatar' />
        <div className='info'>
          <div className='base'>
            <div className='name'>王小峰</div>
            <div className='level'>客户经理，新手</div>
          </div>
          <div className='score'>
            <div className='learned'><Icon type='file-text' /> 已学内容：32</div>
            <div className='exp'><Icon type='share-alt' /> 经验贡献：141</div>
          </div>
        </div>
      </div>
      <a className='show-stat' href='/mobile/learning-center/progress'>查看学习进度统计</a>
    </div>


CustomCenterPage = React.createClass
  render: ->
    <div className='custom-center-page shadow-card'>
      这里显示自定义个人页，要素包括：<br />
      学习计划，学习进度
    </div>