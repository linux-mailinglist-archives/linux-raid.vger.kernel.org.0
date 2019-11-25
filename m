Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1CF108952
	for <lists+linux-raid@lfdr.de>; Mon, 25 Nov 2019 08:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbfKYHky (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 Nov 2019 02:40:54 -0500
Received: from mail.iankelling.org ([72.14.176.105]:45096 "EHLO
        mail.iankelling.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfKYHkx (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 25 Nov 2019 02:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iankelling.org; s=li; h=MIME-Version:Date:In-reply-to:Subject:To:From:
        References; bh=gr9JRenRyc3bVny+JYpqiOUvcF8STV3bJNnmRPT/skM=; b=Zr4oso8dk62SjV
        fjFt2y1DQrNdg91KiqULBEpnBKt/EUhjq0Vvp+7EIMG4aO9nZ0jy4nSdjT+6yHTt0w5w48zmLrH9P
        OJ300LUnV6vLmR0zRJ3jQL66Wll8q99yFGZw2eoPVVVbECNRfTJAfhDRNmn8GuRb6YcY7KbVlYewL
        vgKZsnXzHKndKfMR/K+MPnPTHZPEQsEMXaSlcEi7MzsRCI4AQLuyAebrkqR8lzSk4V1awbUllqAtN
        KtZFrJ8Pg0jBrIBjYI2NQr5DhXhhY91VdTMPHzmrR/qGvCPHHSagNFrHUxY8GHeP0Sh8k1p5gPUcg
        DJB6sl665fei6CIO+UVg==;
Received: from iank by mail.iankelling.org with local (Exim 4.90_1)
        (envelope-from <ian@iankelling.org>)
        id 1iZ8zM-0004yZ-DL; Mon, 25 Nov 2019 02:40:52 -0500
References: <3fc5f3df-0589-645c-f36a-2eee83e8bccd () gnu ! org>
 <877e3ozt9r.fsf@iankelling.org> <871rtw5z9e.fsf@fsf.org>
User-agent: mu4e 1.1.0; emacs 27.0.50
From:   Ian Kelling <ian@iankelling.org>
To:     Ian Kelling <iank@fsf.org>
Cc:     linux-raid@vger.kernel.org
Subject: Re: Deep into potential data loss issue
In-reply-to: <871rtw5z9e.fsf@fsf.org>
Date:   Mon, 25 Nov 2019 02:40:52 -0500
Message-ID: <87zhgk4d4r.fsf@iankelling.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


Ian Kelling <iank@fsf.org> writes:

> seems to have worked.

The partitions showed up, but the filesystems are full of errors and
generally unusable. So, seems it did not really work. We still have the
original partitions untouched.
