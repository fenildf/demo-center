{ Icon, Progress } = antd

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
            <div className='name'>宋亮</div>
            <div className='level'>客户经理，新手</div>
          </div>
          <div className='score'>
            <div className='learned'><Icon type='book' /> 已学内容：52</div>
            <div className='exp'><Icon type='share-alt' /> 讨论贡献：141</div>
          </div>
        </div>
      </div>
      <a className='show-stat'><Icon type='setting' />设置个人信息</a>
    </div>


CustomCenterPage = React.createClass
  render: ->
    <div>
      <div className='custom-center-page shadow-card small plan'>
        <div className='title'>学习计划</div>
        <div className='count'>4</div>
      </div>

      <div className='custom-center-page shadow-card small question'>
        <div className='title'>待解决问题</div>
        <div className='count'>6</div>
      </div>

      <div className='custom-center-page shadow-card small point'>
        <div className='title'>已学知识点</div>
        <div className='count'>32</div>
      </div>

      <div className='custom-center-page shadow-card progress'>
        <Progress percent={66} strokeWidth={7} />
      </div>

      <div className='custom-center-page shadow-card curve'>
        <div className='title'>一周学习曲线</div>
        <div className='ct'>
          <div className='img' />
        </div>
      </div>

      <div className='custom-center-page shadow-card nengli'>
        <div className='title'>个人能力构成</div>
        <div className='ct'>
          <div className='img' />
        </div>
      </div>
    </div>