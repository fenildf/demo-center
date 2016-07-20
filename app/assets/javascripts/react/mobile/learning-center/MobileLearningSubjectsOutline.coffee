{ Icon } = antd

module.exports = MobileLearningSubjectsOutline = React.createClass
  render: ->
    <MobileLearningCenterSecondaryLayout 
      title='课程分级导航'
      back_to='/mobile/learning-center/subjects'
    >
      <KNetHeader />
    </MobileLearningCenterSecondaryLayout>


KNetHeader = React.createClass
  render: ->
    imgurl = 'http://i.teamkn.com/i/Ivl1XEL0.jpg'

    <div className='knet-header shadow-card'>
      <div className='title'>银行职业培训</div>
      <div className='time'>更新于：5小时前</div>
      <div className='image' style={backgroundImage: "url(#{imgurl})"} />
      <div className='desc'>银行业从业员工需要掌握的各种知识技能</div>
      <div className='stat'>
        <div className='s s2'>
          <Icon type='message' /> 27
        </div>
        <div className='s s1'>
          <Icon type='team' /> 45
        </div>
      </div>
    </div>