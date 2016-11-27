package ssm.model;



import java.util.List;

public class treeNodeModel {
	
	
	
	public int getNodeid() {
		return nodeid;
	}



	public void setNodeid(int nodeid) {
		this.nodeid = nodeid;
	}



	public String getText() {
		return text;
	}



	public void setText(String text) {
		this.text = text;
	}



	public List<treeNodeModel> getNodes() {
		return nodes;
	}



	public void setNodes(List<treeNodeModel> nodes) {
		this.nodes = nodes;
	}


	private int nodeid;
	private String text;
	
	private List<treeNodeModel> nodes;
	
	
	
    public void treeNodeUitl(int id, String str, List<treeNodeModel> node)
    {
    	nodeid = id;
        text = str;
        nodes = node;
    }
    
    
    //子节点，可以用递归的方法读取，方法在下一章会总结
}
