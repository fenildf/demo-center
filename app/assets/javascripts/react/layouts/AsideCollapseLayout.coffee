{ Menu, Icon, Breadcrumb } = antd

module.exports = AsideCollapseLayout = React.createClass
  getInitialState: ->
    collapse: true

  change_collapse: ->
    @setState collapse: not @state.collapse
  
  render: ->
    classes = ClassName
      'ant-layout-aside': true
      'ant-layout-aside-collapse': @state.collapse

    <div className={classes}>
      <Aside 
        collapse={@state.collapse} 
        change_collapse={@change_collapse}
      />

      <div className="ant-layout-main">
        <div className="ant-layout-header"></div>
        <div className="ant-layout-breadcrumb">
          <Breadcrumb>
            <Breadcrumb.Item>首页</Breadcrumb.Item>
            <Breadcrumb.Item>应用列表</Breadcrumb.Item>
            <Breadcrumb.Item>某应用</Breadcrumb.Item>
          </Breadcrumb>
        </div>
        <div className="ant-layout-container">
          <div className="ant-layout-content">
            <div style={{ height: 220 }}>
              {
                console.log @props.content_component.name
                React.createElement eval(@props.content_component.name), null
              }
            </div>
          </div>
        </div>
        <div className="ant-layout-footer">
        Ant Design 版权所有 © 2015 由蚂蚁金服体验技术部支持
        </div>
      </div>

    </div>


Aside = React.createClass
  render: ->
    logo =
      <div className='ant-layout-logo'></div>

    aside_action =
      <div className='ant-aside-action' onClick={@props.change_collapse}>
        <Icon type={if @props.collapse then 'right' else 'left'} />
      </div>

    <aside className='ant-layout-sider'>
      {logo}

      <Menu mode="inline" theme="dark" defaultSelectedKeys={['user']}>
        <Menu.Item key="user">
          <Icon type="user" /><span className="nav-text">导航一</span>
        </Menu.Item>
        <Menu.Item key="setting">
          <Icon type="setting" /><span className="nav-text">导航二</span>
        </Menu.Item>
        <Menu.Item key="laptop">
          <Icon type="laptop" /><span className="nav-text">导航三</span>
        </Menu.Item>
        <Menu.Item key="notification">
          <Icon type="notification" /><span className="nav-text">导航四</span>
        </Menu.Item>
        <Menu.Item key="folder">
          <Icon type="folder" /><span className="nav-text">导航五</span>
        </Menu.Item>
      </Menu>

      {aside_action}
    </aside>