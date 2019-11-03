package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.JobIntrvReviewDTO;
import poly.persistance.mapper.JobIntrvReviewMapper;
import poly.service.IJobIntrvReviewService;

@Service("JobIntrvReviewService")
public class JobIntrvReviewService implements IJobIntrvReviewService {
	
	@Resource(name="JobIntrvReviewMapper")
	private JobIntrvReviewMapper jirMapper;
	
	@Override
	public List<JobIntrvReviewDTO> getReviewList() throws Exception {
		return jirMapper.getReviewList();
	}

	@Override
	public JobIntrvReviewDTO getReviewDetail(String reviewNo) throws Exception {
		return jirMapper.getReviewDetail(reviewNo);
	}

	@Override
	public int insertReview(JobIntrvReviewDTO jirDTO) throws Exception {
		return jirMapper.insertReview(jirDTO);
	}

	@Override
	public int updateReview(JobIntrvReviewDTO jirDTO) throws Exception {
		return jirMapper.updateReview(jirDTO);
	}

	@Override
	public int deleteReview(String targetReviewNo) throws Exception {
		return jirMapper.deleteReview(targetReviewNo);
	}

}
