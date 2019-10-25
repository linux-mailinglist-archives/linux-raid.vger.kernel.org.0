Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1065BE409C
	for <lists+linux-raid@lfdr.de>; Fri, 25 Oct 2019 02:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbfJYAbW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 24 Oct 2019 20:31:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55134 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfJYAbW (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 24 Oct 2019 20:31:22 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1iNnVg-0001gP-6q
        for linux-raid@vger.kernel.org; Fri, 25 Oct 2019 00:31:20 +0000
Received: by mail-il1-f197.google.com with SMTP id f17so701908ilc.8
        for <linux-raid@vger.kernel.org>; Thu, 24 Oct 2019 17:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qULecV+DGcErG+gYHJLMII0QjMGqpqwRbijnF1xaLf4=;
        b=d03Pxeb9ThMlqoGCLTcS4Job7KGLT9u9UakFvGA8tpmX+L4tdXXr2vS1PnlRVIwBcs
         BFfd2vQUbXluzR6/aMwU32GgGBDfRbMBHntWp5BHOcBdXPxygscss+W2hBKjeePxqC/Q
         4D6CcVfrSsv+z43m/fWs3Br1AZxhNLAoLYnR7lXcDQWmtakQ+OxtxFQ0yCnWTZvOuW4W
         m6JSFQyFwReZF0Dsx7XHy3bwrDBpAEFNm/NahfhGQGlR1WNsp0pT9MjWwlCeTRo9DR9n
         DbLeMCwwL4BPEW77oLgqNdDW4Ea3V/1ZnseJKL63j5pC4SVVs4wYP5c4M3wDitiMB/Ni
         wnsA==
X-Gm-Message-State: APjAAAXHRR1xf3k//9FWJHf5Fo1lkce4qHlO+6yGi5qe0E+zqN6pNdys
        QRqJxsgqBL0tL4iCEQC1tCScR5ywhSChgHLFH5RNjObXQUx+qkVEGJlDXpKVMQi7TEAeuI0FmtO
        iOrd5DVjck8KwJGoNG+K80al4qMl2w2NPmMq8FYk=
X-Received: by 2002:a6b:ee1a:: with SMTP id i26mr964093ioh.202.1571963478944;
        Thu, 24 Oct 2019 17:31:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqynJClWc63jfijpLH8BYjPn4plMUnmbo0o/fDYOVCOIDc5a6PPulnHO6H3gVfALjUwNGe1b/A==
X-Received: by 2002:a6b:ee1a:: with SMTP id i26mr964068ioh.202.1571963478668;
        Thu, 24 Oct 2019 17:31:18 -0700 (PDT)
Received: from xps13.canonical.com (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
        by smtp.gmail.com with ESMTPSA id i198sm148955ioa.5.2019.10.24.17.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 17:31:18 -0700 (PDT)
Date:   Thu, 24 Oct 2019 18:31:17 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-raid@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Ivan Topolsky <doktor.yak@gmail.com>
Subject: admin-guide page for raid0 layout issue
Message-ID: <20191025003117.GA19595@xps13.dannf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

hey,
  I recently hit the raid0 default_layout issue and found the warning
message to be lacking (and google hits show that I'm not the
only one). It wasn't clear to me that it was referring to a kernel
parameter, also wasn't clear how I should decide which setting to use,
and definitely not clear that picking the wrong one could *cause
corruption* (which, AIUI, is the case). What are your thoughts on
adding a more admin-friendly explanation/steps on resolving the
problem to the admin-guide, and include a URL to it in the warning
message? As prior art:

  https://github.com/torvalds/linux/commit/6a012288d6906fee1dbc244050ade1dafe4a9c8d

If the idea has merit, let me know if you'd like me to take a stab at
a strawdog.

 -dann
