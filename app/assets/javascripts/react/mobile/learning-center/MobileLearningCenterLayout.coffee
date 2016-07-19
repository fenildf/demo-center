{ Icon } = antd

module.exports = MobileLearningCenterLayout = React.createClass
  render: ->
    title = @props.title

    <div className='mobile-learning-center'>
      <HeaderBar title={title} />
      <MobileContent>
        {@props.children}
      </MobileContent>
      <FootMenu active={@props.menu_active} />
    </div>

HeaderBar = React.createClass
  render: ->
    <div className='header-bar'>
      <div className='title'>{@props.title}</div>
    </div>

FootMenu = React.createClass
  render: ->
    classes_arr = [1, 2, 3, 4].map (x)=>
      ClassName
        "link l#{x}": true
        "active": x == @props.active

    <div className='foot-menu'>
      <a className='link-me' href='/mobile/learning-center'>
        <Icon type='user' /><span>我</span>
      </a>

      <a className={classes_arr[0]} href='/mobile/learning-center/plan'>
        <Icon type='book' /><span>计划</span>
      </a>
      <a className={classes_arr[1]} href='/mobile/learning-center/messages'>
        <Icon type='message' /><span>消息</span>
        <div className='new-count'>7</div>
      </a>

      <a className={classes_arr[2]}>
        <Icon type='question-circle-o' /><span>??</span>
      </a>
      <a className={classes_arr[3]}>
        <Icon type='question-circle-o' /><span>??</span>
      </a>
    </div>

MobileContent = React.createClass
  render: ->
    <div className='mobile-content'>
      {@props.children}
    </div>