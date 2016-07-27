{ Icon } = antd

module.exports = MobileLearningCenterLayout = React.createClass
  render: ->
    title = @props.title

    <div className='mobile-learning-center'>
      <HeaderBar title={title} right_icon={@props.right_icon} />
      <MobileContent>
        {@props.children}
      </MobileContent>
      <FootMenu active={@props.menu_active} />
    </div>

HeaderBar = React.createClass
  render: ->
    <div className='header-bar'>
      <div className='title'>{@props.title}</div>
      {
        if @props.right_icon?
          <Icon className='right-icon' type={@props.right_icon} />
      }
    </div>

FootMenu = React.createClass
  render: ->
    classes_arr = [1, 2, 3, 4].map (x)=>
      ClassName
        "link l#{x}": true
        "active": x == @props.active

    <div className='foot-menu'>
      <a className='link-me' href='/mobile/learning-center'>
        <Icon type='solution' /><span>我</span>
      </a>

      <a className={classes_arr[0]} href='/mobile/learning-center/subjects'>
        <Icon type='book' /><span>课程</span>
      </a>
      <a className={classes_arr[1]} href='/mobile/learning-center/plan'>
        <Icon type='bars' /><span>计划</span>
      </a>
      <a className={classes_arr[2]} href='/mobile/learning-center/messages'>
        <Icon type='message' /><span>消息</span>
        <div className='new-count'>…</div>
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