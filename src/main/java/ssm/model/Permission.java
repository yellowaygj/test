package ssm.model;

public class Permission {
	  public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescribe() {
		return describe;
	}
	public void setDescribe(String describe) {
		this.describe = describe;
	}

	public Integer getFlevel() {
		return flevel;
	}
	public void setFlevel(Integer flevel) {
		this.flevel = flevel;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	private Integer id;
	  private String name;
	  private String describe;
	  private Integer state;
	  public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}

	private Integer flevel;
	  private String url;

}
