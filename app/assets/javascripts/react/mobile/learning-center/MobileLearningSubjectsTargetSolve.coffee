{ Icon } = antd

module.exports = MobileLearningSubjectsTargetSolve = React.createClass
  render: ->
    subjects = [
      '2-3', '2-2'
    ].map (id)=>
      arr = id.split('-').map (x)-> x - 1
      subject = 
        children: @props.points
      for idx in arr
        subject = subject.children[idx]
      subject

    console.log subjects

    <MobileLearningCenterSecondaryLayout 
      title='问题解答'
      back_to='/mobile/learning-center/subjects/target/'
    >
      <div className='question-solve shadow-card'>
        <div className='title'>
          <Icon type='question-circle' /> 如何理解理财产品的流动性？
        </div>
        <div className='tags'>
          <div className='tag'><Icon type='tag' /> 理财产品</div>
          <div className='tag'><Icon type='tag' /> 流动性</div>
          <div className='tag'><Icon type='tag' /> 收益</div>
        </div>
        <div className='answer'>
          <div style={fontWeight: 'bold'}>回答：</div>
          <div>流动性指的是变现能力，如果变现越容易，就说明流动性就好。相应的，收益率会降低。<br />一般来说，流动性越高，收益率越低。但如果要准确评估一款理财产品，流动性，收益率，风险都需要考虑在内。</div>
        </div>
      </div>

      <h3>相关知识点</h3>
      <SubjectsTree
        key={'solve'}
        subjects={subjects}
        _filter={(x)-> true}
      />
    </MobileLearningCenterSecondaryLayout>