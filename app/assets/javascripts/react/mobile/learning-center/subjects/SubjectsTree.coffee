{ Icon, Progress } = antd

module.exports = SubjectsTree = React.createClass
  render: ->
    subjects = @props.subjects.filter @props._filter

    <div className='subjects-tree'>
    {
      for subject in subjects
        <Subject 
          key={subject.id} 
          subject={subject} 
          _filter={@props._filter}
          depth={0}
        />
    }
    </div>


Subject = React.createClass
  render: ->
    subject = @props.subject
    subjects = (subject.children || [])
    subjects = subjects.filter @props._filter
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
        {
          if subject.new
            <div className='is-new'>new</div>
        }
      </a>
      <SubjectChildren 
        subject={subject}
        subjects={subjects} 
        _filter={@props._filter}
        parent_component={@props.parent_component}
        depth={@props.depth}
      />
    </div>

SubjectChildren = React.createClass
  getInitialState: ->
    if @props.depth == 0
      collapse: false
    else
      collapse: true 

  render: ->
    if @props.subjects.length is 0
      <div />

    else
      classes = ClassName
        'children': true
        'collapse': @state.collapse

      if @props.depth <=1
        action =
          <a className='action' onClick={@toggle}>
          {
            if @state.collapse
              <Icon type='right' />
            else
              <Icon type='down' />
          }
          </a>
      else
        action = <div />


      <div className={classes} ref='children'>
        <canvas ref='canvas' />
        {action}

        {
          if @props.depth <=1
            <a className='brief' onClick={@toggle}>{@props.subjects.length} 个下层知识点…</a>
          else
            href = "/mobile/learning-center/subjects/outline##{@props.subject.id}"
            <a className='brief' href={href}>{@props.subjects.length} 个下层知识点…</a>
        }

        <div className='subjects'>
        {
          for subject in @props.subjects
            <Subject 
              key={subject.id} 
              subject={subject} 
              _filter={@props._filter}
              parent_component={@}
              depth={@props.depth + 1}
            />
        }
        </div>
      </div>

  toggle: ->
    @setState collapse: not @state.collapse

  componentDidMount: ->
    setTimeout =>
      @draw()
    , 1

  componentDidUpdate: ->
    @draw()

  draw: ->
    return if @props.subjects.length is 0

    if not @state.collapse
      @resize_canvas()
      @drawline()
    @props.parent_component?.draw()

  resize_canvas: ->
    canvas_dom = ReactDOM.findDOMNode @refs.canvas
    $children = jQuery ReactDOM.findDOMNode @refs.children
    
    children_height = $children.height()

    canvas_dom.height = children_height
    canvas_dom.width = 50

    jQuery(canvas_dom)
      .css
        left: -44
        top: 0

  drawline: ->
    canvas_dom = ReactDOM.findDOMNode @refs.canvas
    ctx = canvas_dom.getContext '2d'
    ctx.strokeStyle = '#ccc'
    ctx.lineWidth = 2

    $children = jQuery ReactDOM.findDOMNode @refs.children
    ctop = $children.offset().top

    $children.find('> .subjects > .subject').each (idx, subject)->
      top = jQuery(subject).offset().top - ctop
      
      ctx.beginPath()
      ctx.moveTo 15, 15
      ctx.lineTo 15, top + 9
      ctx.lineTo 21, top + 15
      ctx.lineTo 46, top + 15
      ctx.stroke()