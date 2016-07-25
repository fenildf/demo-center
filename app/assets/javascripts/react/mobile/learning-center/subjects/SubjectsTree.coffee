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
      </a>
      <div className='children'>
      {
        for subject in subjects
          <Subject 
            key={subject.id} 
            subject={subject} 
            _filter={@props._filter}
          />
      }
      </div>
    </div>