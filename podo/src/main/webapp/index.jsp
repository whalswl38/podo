<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/header.jsp" %>
<style type="text/css">
</style>
</head>
<body>
<%@ page import="com.sist.date.expireFlag" %>
<%@ page import="org.apache.logging.log4j.LogManager" %>
<%@ page import="org.apache.logging.log4j.Logger" %>
<%
	//마감여부 관련 날짜 스레드 실행
	Logger logger = LogManager.getLogger("/board/comList.jsp");
	Thread timeDiff = new expireFlag();
	timeDiff.start(); 
%>
<%@ include file="/include/navigation.jsp" %>
	<header class="bg-white py-5">
           <div class="container px-5">
	            <div class="row gx-5 align-items-center justify-content-center">
	                <div class="col-lg-8 col-xl-7 col-xxl-6">
	                    <div class="my-5 text-center  text-xl-start">
	                        <h1 class="display-5 fw-bolder text-dark mb-2">Are you looking for a company? Welcome. Enjoy Podo right now.</h1>
	                        <p class="lead fw-normal text-dark mb-4">We match good companies and create a better portfolio for you.</p><br/>
	                        <div class="input-group mb-3">
		                        <input id="gnb_search" placeholder="Please enter your search term" value="" required="" class="form-control">
		                        <button id="submit" aria-label="submit" class="btn btn-purple">
			                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
										<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
									</svg>
		                        </button>
	                        </div>
	                        
	                    </div>
	                </div>
	                <div class="col-xl-5 col-xxl-6 d-none d-xl-block text-center"><img class="img-fluid rounded-3 my-5" src="https://img.freepik.com/free-psd/3d-nft-icon-developer-male-illustration_629802-6.jpg?w=740&t=st=1705670811~exp=1705671411~hmac=55d274d39d42b4f27c3b2b7cd2357dd55c25570a103c65f601a571bfea7a8baf" width="400px" height="400px"/></div>
	            </div>
	        </div>
<script>
</script>	        
	</header>
	<!-- Section-->
	<section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Recruitment image-->
                            <img class="card-img-top" src="/resources/img/compa1.jpg" alt="..." />
                            <!-- Recruitment -->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Recruitment name-->
                                    <h5 class="fw-bolder">웹 개발 각 분야별 모집</h5><br/>
                                    <!-- Recruitment details-->
                                    <span class="text-muted">개발 및 유지보수(백엔드)</span>
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a id ="button" class="btn btn-purple mt-auto" href="#">바로가기</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Sale badge-->
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">취업지원금</div>
                            <!-- Recruitment image-->
                            <img class="card-img-top" src="/resources/img/compa2.png" alt="..." />
                            <!-- Recruitment -->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Recruitment name-->
                                    <h5 class="fw-bolder">Web 개발자 채용</h5><br/>
                                    <!-- Recruitment details-->
                                    <span class="text-muted">Web 시스템 운영 및 개발</span>
                                </div>
                            </div>
                            <!-- Recruitment actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a id ="button" class="btn btn-purple mt-auto" href="#">바로가기</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- badge-->
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">취업지원금</div>
                            <!-- Recruitment image-->
                            <img class="card-img-top" src="/resources/img/compa3.png" alt="..." />
                            <!-- Recruitment -->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Recruitment name-->
                                    <h5 class="fw-bolder">UI, UX 디자이너 채용</h5><br/>
                                    <!-- Recruitment details-->
                                    <span class="text-muted">홈페이지 및 기타 운영 페이지의 기획</span>
                                </div>
                            </div>
                            <!-- Recruitment actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a id ="button" class="btn btn-purple mt-auto" href="#">바로가기</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Recruitment image-->
                            <img class="card-img-top" src="/resources/img/compa4.png" alt="..." />
                            <!-- Recruitment -->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Recruitment name-->
                                    <h5 class="fw-bolder">Java 운영 개발자 채용</h5><br/>
                                    <!-- Recruitment details-->
                                    <span class="text-muted">시스템 운영 및 개발</span>
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a id ="button" class="btn btn-purple mt-auto" href="#">바로가기</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- badge-->
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">취업지원금</div>
                            <!-- Product image-->
                            <img class="card-img-top" src="/resources/img/compa5.png" alt="..." />
                            <!-- Product -->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">웹 솔루션 PM 채용</h5><br/>
                                    <!-- Recruitment details-->
                                    <span class="text-muted ">임상시험 관련 솔루션 개발</span>
                                </div>
                            </div>
                            <!-- Recruitment actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a id ="button" class="btn btn-purple mt-auto" href="#">바로가기</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Recruitment image-->
                            <img class="card-img-top" src="/resources/img/compa6.png" alt="..." />
                            <!-- Recruitment -->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Recruitment name -->
                                    <h5 class="fw-bolder">App 프론트 개발자 모집</h5><br/>
                                    <!-- Recruitment details-->
                                    <span class="text-muted">JavaScript, React</span>
                                </div>
                            </div>
                            <!-- Recruitment actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a id ="button" class="btn btn-purple mt-auto" href="#">바로가기</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- badge-->
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">취업지원금</div>
                            <!-- Recruitment image-->
                            <img class="card-img-top" src="/resources/img/compa7.jpg" alt="..." />
                            <!-- Recruitment -->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Recruitment name -->
                                    <h5 class="fw-bolder">웹 풀스택 개발자</h5><br/>
                                    <!-- Recruitment details-->
                                    <span class="text-muted">게임 관련 서비스 개발</span>
                                </div>
                            </div>
                            <!-- Recruitment actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a id ="button" class="btn btn-purple mt-auto" href="#">바로가기</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Recruitment image-->
                            <img class="card-img-top" src="/resources/img/compa8.jpg" alt="..." />
                            <!-- Recruitment -->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Recruitment name-->
                                    <h5 class="fw-bolder">중견기업 웹 개발자채용</h5><br/>
                                    <!-- Recruitment details-->
                                    <span class="text-muted">Web기반 시스템 개발 및 유지보수</span>
                                </div>
                            </div>
                            <!-- Recruitment actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a id ="button" class="btn btn-purple mt-auto" href="#">바로가기</a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
	</section>
<%@ include file="/include/footer.jsp" %>
</body>
</html>